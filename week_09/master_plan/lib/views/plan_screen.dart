import '../models/data_layer.dart';
import 'package:flutter/material.dart';

import '../provider/plan_provider.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan;
  const PlanScreen({super.key, required this.plan});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final plansNotifier = PlanProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.plan.name)),
      body: ValueListenableBuilder<List<Plan>>(
        valueListenable: plansNotifier,
        builder: (context, plans, child) {
          final currentPlan = plans.firstWhere(
            (p) => p.name == widget.plan.name,
            orElse: () => widget.plan,
          );
          return Column(
            children: [
              Expanded(child: _buildList(currentPlan)),
              SafeArea(child: Text(currentPlan.completenessMessage)),
            ],
          );
        },
      ),
      floatingActionButton: _buildAddTaskButton(context),
    );
  }

  Widget _buildList(Plan plan) {
    return ListView.builder(
      controller: scrollController,
      itemCount: plan.tasks.length,
      itemBuilder: (context, index) =>
          _buildTaskTile(plan.tasks[index], index, context),
    );
  }

  Widget _buildTaskTile(Task task, int index, BuildContext context) {
    final planNotifier = PlanProvider.of(context);
    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (selected) {
          final plans = planNotifier.value;
          final planIndex = plans.indexWhere((p) => p.name == widget.plan.name);
          if (planIndex == -1) return;
          final currentPlan = plans[planIndex];
          final updatedPlan = Plan(
            name: currentPlan.name,
            tasks: List<Task>.from(currentPlan.tasks)
              ..[index] = Task(
                description: task.description,
                complete: selected ?? false,
              ),
          );
          planNotifier.value = List<Plan>.from(plans)
            ..[planIndex] = updatedPlan;
        },
      ),
      title: TextFormField(
        initialValue: task.description,
        onChanged: (text) {
          final plans = planNotifier.value;
          final planIndex = plans.indexWhere((p) => p.name == widget.plan.name);
          if (planIndex == -1) return;
          final currentPlan = plans[planIndex];
          final updatedPlan = Plan(
            name: currentPlan.name,
            tasks: List<Task>.from(currentPlan.tasks)
              ..[index] = Task(description: text, complete: task.complete),
          );
          planNotifier.value = List<Plan>.from(plans)
            ..[planIndex] = updatedPlan;
        },
      ),
    );
  }

  Widget _buildAddTaskButton(BuildContext context) {
    final planNotifier = PlanProvider.of(context);
    return FloatingActionButton(
      child: const Icon(Icons.add),
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
      onPressed: () {
        final plans = planNotifier.value;
        final planIndex = plans.indexWhere((p) => p.name == widget.plan.name);
        if (planIndex == -1) return;
        final currentPlan = plans[planIndex];
        final updatedPlan = Plan(
          name: currentPlan.name,
          tasks: List<Task>.from(currentPlan.tasks)..add(const Task()),
        );
        planNotifier.value = List<Plan>.from(plans)..[planIndex] = updatedPlan;
      },
    );
  }
}
