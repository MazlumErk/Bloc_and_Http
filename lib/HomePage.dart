import 'package:bloc_and_http/Cubit/NameCubit.dart';
import 'package:bloc_and_http/Data/Names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'Models/NameModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final url = Uri.parse('https://reqres.in/api/users');

  Future getName() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var result = nameFromJson(response.body);
        if (mounted) {
          for (var i = 0; i < result.data.length; i++) {
            Names.nameList.add(result.data[i].firstName.toString());
          }
          setState(() {});
          return result;
        }
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NamesCubit>(
      create: (_) => NamesCubit(nameList: Names.nameList),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc And Http'),
      ),
      body: BlocBuilder<NamesCubit, String?>(
        builder: (context, String? nameState) {
          final getNameButton = TextButton(
              onPressed: () {
                context.read<NamesCubit>().getRandomName();
              },
              child: Text('Get Name'));
          if (nameState != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      nameState.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(child: getNameButton),
                )
              ],
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(child: SizedBox()),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(child: getNameButton),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
