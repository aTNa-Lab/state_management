import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:state_management/bloc/counter_bloc.dart';
import 'package:state_management/models/counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const SimpleStateWidget(),
      // home: const ProviderStateWidget(),
      home: const BlocStateWidget(),
    );
  }
}

class BlocStateWidget extends StatelessWidget {
  const BlocStateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(),
      child: const BlocStateView(),
    );
  }
}

class BlocStateView extends StatelessWidget {
  const BlocStateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            BlocBuilder<CounterBloc, CounterState>(builder: (context, state) {
              return Text('Counter is ${state.counter}');
            }),
            TextButton(
                onPressed: () {
                  context.read<CounterBloc>().add(IncrementCounter());
                },
                child: const Text('+')),
            TextButton(
                onPressed: () {
                  context.read<CounterBloc>().add(DecrementCounter());
                },
                child: const Text('-'))
          ],
        ),
      ),
    );
  }
}

class ProviderStateWidget extends StatelessWidget {
  const ProviderStateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: const ProviderStateView(),
    );
  }
}

class ProviderStateView extends StatelessWidget {
  const ProviderStateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Consumer<CounterModel>(
              builder: (context, model, child) {
                return Text('Counter is ${model.counter}');
              },
            ),
            TextButton(
                onPressed: () {
                  Provider.of<CounterModel>(context, listen: false).increment();
                },
                child: const Text('+')),
            TextButton(
                onPressed: () {
                  Provider.of<CounterModel>(context, listen: false).decrement();
                },
                child: const Text('-'))
          ],
        ),
      ),
    );
  }
}

class SimpleStateWidget extends StatefulWidget {
  const SimpleStateWidget({Key? key}) : super(key: key);

  @override
  State<SimpleStateWidget> createState() => _SimpleStateWidgetState();
}

class _SimpleStateWidgetState extends State<SimpleStateWidget> {
  late int _counter;

  @override
  void initState() {
    _counter = 3;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Counter is $_counter'),
            TextButton(
                onPressed: () {
                  setState(() {
                    _counter++;
                  });
                },
                child: const Text('+')),
            TextButton(
                onPressed: () {
                  setState(() {
                    _counter--;
                  });
                },
                child: const Text('-'))
          ],
        ),
      ),
    );
  }
}
