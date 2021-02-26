
import 'dart:ui';


// ignore: public_member_api_docs
void registerPlugins(PluginRegistry registry) {
  ConnectivityPlugin.registerWith(registry.registrarFor(ConnectivityPlugin));
  FirebaseAuthWeb.registerWith(registry.registrarFor(FirebaseAuthWeb));
  FirebaseCoreWeb.registerWith(registry.registrarFor(FirebaseCoreWeb));
  registry.registerMessageHandler();
}
