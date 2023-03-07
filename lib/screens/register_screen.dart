import 'package:fl_productos_app/providers/login_provider.dart';
import 'package:fl_productos_app/ui/input_decoration.dart';
import 'package:fl_productos_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [

              const SizedBox(height: 250,),

              CardContainer(
                child: Column(
                  children: [

                    const SizedBox(height: 10,),
                    Text('Registro', style: Theme.of(context).textTheme.headlineMedium,),
                    const SizedBox(height: 30,),

                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: const _LoginForm(),
                    )

                  ],
                ),
              ),

              const SizedBox(height: 50,),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                    shape: MaterialStateProperty.all(StadiumBorder())
                ),
                child: const Text('¿Ya tienes una cuenta?', style: TextStyle(fontSize: 18, color: Colors.black87)),
              ),
              const SizedBox(height: 50,),

            ],
          ),
        )
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final loginFormProvider = Provider.of<LoginFormProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        //Mantener la referencia al KEY
        key: loginFormProvider.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(
          children: [

            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'example@gmail.com',
                  labelText: 'Correo electrónico',
                  prefixIcon: Icons.alternate_email_sharp
              ),
              onChanged: (value) => loginFormProvider.email = value,
              validator: (value){

                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Ingrese un correo valido';
              },
            ),

            const SizedBox(height: 30,),

            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '*****',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_outline
              ),
              onChanged: (value) => loginFormProvider.password = value,
              validator: (value){

                return (value != null && value.length >= 6)
                  ? null
                  : 'La contraseña no es valida';
              },
            ),

            const SizedBox(height: 30,),

            MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                onPressed: loginFormProvider.isLoading ? null : () async {
                  
                  FocusScope.of(context).unfocus();
                  
                  if(!loginFormProvider.isValidForm()) return;

                  loginFormProvider.isLoading = true;

                  await Future.delayed(const Duration(seconds: 2));

                  //TODO: Validar si es correcto
                  loginFormProvider.isLoading = false;
                  
                  Navigator.pushReplacementNamed(context, 'home');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 15
                  ),
                  child: Text(
                    loginFormProvider.isLoading
                      ? 'Espere'
                      : 'Ingresar',
                    style: const TextStyle(color: Colors.white),
                  ),
                )
            ),

            const SizedBox(height: 20,),
          ],

        ),
      ),
    );
  }
}
