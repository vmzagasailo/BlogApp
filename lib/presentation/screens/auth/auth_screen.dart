import 'package:blog_app/core/validation/validation_mixin.dart';
import 'package:blog_app/middleware/blocs/auth/auth_bloc.dart';
import 'package:blog_app/middleware/blocs/auth/auth_state.dart';
import 'package:blog_app/presentation/core/ui_utils.dart';
import 'package:blog_app/presentation/core/validators/password_validator.dart';
import 'package:blog_app/presentation/resources/resources.dart';
import 'package:blog_app/presentation/widgets/design_button.dart';
import 'package:blog_app/presentation/widgets/design_clicable_text_span.dart';
import 'package:blog_app/presentation/widgets/design_scaffold.dart';
import 'package:blog_app/presentation/widgets/design_text_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/authScreen';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with ValidationMixin {
  late final AuthCubit authBloc;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailValid = ValueNotifier<bool>(false);
  final _passwordValid = ValueNotifier<bool>(false);

  bool _signInMode = true;

  @override
  void initState() {
    startValidating([_emailValid, _passwordValid]);
    authBloc = BlocProvider.of<AuthCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DesignScaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: UiUtils.withHorizontalPadding(
        SizedBox(
          height: UiUtils.getEffectiveHeight(context),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) => Column(
              children: [
                const Spacer(flex: 2),
                Text(
                  !state.signInMode ? 'Let\'s create your account' : 'Sign In',
                  style: TextStyles.heading24,
                ),
                _buildEmailSection(state),
                const SizedBox(height: 10),
                _buildPasswordSection(state),
                const SizedBox(height: 10),
                DesignButton(
                  onTap: () => _onAuthTap(state),
                  title: !state.signInMode ? 'Create account' : 'Sign In',
                  enabled: isValid,
                ),
                const Spacer(flex: 6),
                DesignClickableTextSpan(
                  onTap: _onTextSpanTap,
                  strings: [
                    !state.signInMode
                        ? 'Already have an account? '
                        : 'Dont have an account? ',
                    !state.signInMode ? 'Sign in' : 'Create Account'
                  ],
                  colors: const [AppColors.black, AppColors.blue],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailSection(AuthState state) {
    return Column(
      children: [
        if (state.error.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            state.error,
            style: TextStyles.body16.copyWith(color: AppColors.red),
          ),
          const SizedBox(height: 4),
        ] else
          const SizedBox(height: 40),
        DesignTextField(
          controller: _emailController,
          isValid: _emailValid,
          validator: EmailValidator.validate,
          hint: 'Your email',
          inputAction: TextInputAction.next,
        ),
      ],
    );
  }

  Widget _buildPasswordSection(AuthState state) {
    return DesignTextField(
      controller: _passwordController,
      isValid: _passwordValid,
      validator: PasswordValidator.validate,
      hint: !state.signInMode ? 'New password' : 'You password',
      obscureText: true,
      showObscureStatus: true,
      inputAction: TextInputAction.go,
    );
  }

  void _onAuthTap(AuthState state) {
    if (!state.signInMode) {
      authBloc.createUserWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text,
      );
    } else {
      authBloc.signInWithEmailPassword(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  void _onTextSpanTap() {
    authBloc.switchAuthMode(_signInMode);
    _signInMode = !_signInMode;
    _passwordController.clear();
    _emailController.clear();
  }

  @override
  void dispose() {
    stopValidating();
    _emailController.dispose();
    _passwordController.dispose();
    _emailValid.dispose();
    _passwordValid.dispose();
    super.dispose();
  }
}
