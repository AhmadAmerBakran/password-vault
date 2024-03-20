import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/vault_cubit.dart';
import '../../core/vault_state.dart';
import '../widgets/credential_list.dart';
import 'credential_screen.dart';

class VaultScreen extends StatelessWidget {
  const VaultScreen({super.key});

  void _addNewCredential(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CredentialScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => context.read<VaultCubit>().closeVault(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Your Vault")),
        body: BlocConsumer<VaultCubit, VaultState>(
          listenWhen: (previous, current) =>
          current.status == VaultStatus.closed,
          listener: (context, state) => Navigator.pop(context),
          builder: (context, state) => CredentialList(credentials: state.credentials),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addNewCredential(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}