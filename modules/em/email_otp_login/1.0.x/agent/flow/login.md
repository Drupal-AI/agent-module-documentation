<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Email OTP Login — login flow

All behavior below is grounded in the module source; no configuration exists.

## Install / enable

`drush en email_otp_login`. No settings form, no config objects, no permissions, no update hooks
(no `.install`), no library dependencies. To make the flow reachable by users, add a menu link (or
a login-block link) pointing at `/otp-email`.

## Routes (`email_otp_login.routing.yml`)

- `email_otp_login.email_form` — path `/otp-email`, `_form: OtpEmailForm`,
  `_permission: 'access content'`, methods `[GET, POST]`.
- `email_otp_login.validate_otp` — path `/validate-otp/{email}`, `_form: OtpValidation`,
  `_permission: 'access content'`, methods `[GET, POST]`.

There is no `*.permissions.yml`; the module defines no permissions of its own.

## Services (`email_otp_login.services.yml`)

- `Drupal\email_otp_login\OtpGeneratorService` (alias `email_otp_login.generator`).
  `generateOtp(): int` → `return random_int(100000, 999999);` — a 6-digit code from PHP's CSPRNG.
- `Drupal\email_otp_login\MailerService` (alias `email_otp_login.mailer`), autowired.
  `sendOtpEmail(string $email, int $otp): void` calls
  `MailManagerInterface::mail('email_otp_login', 'otp_email', $email, $langcode, ['otp' => $otp])`,
  where `$langcode` is `languageManager->getDefaultLanguage()->getId()`.
- `Drupal\email_otp_login\Hook\EmailOtpLoginHooks`, autowired — see mail below.

## Step 1 — request a code: `OtpEmailForm`

`src/Form/OtpEmailForm.php`, form id `otp_email_form`, extends `FormBase`, uses `AutowireTrait`.
Injects `MailerService`, `OtpGeneratorService`, `StateInterface`, `EntityTypeManagerInterface`.

- `buildForm()`: if `currentUser()->isAuthenticated()`, shows a status message ("You are already
  logged in…") and returns without the field. Otherwise renders a required `email` textfield and a
  submit button.
- `submitForm()`:
  - Loads users by `['mail' => $email]` via the `user` storage; takes `reset($users)`.
  - If none found → error "Email address not found." and returns.
  - If `$user->isBlocked()` → error and returns (no code sent for blocked accounts).
  - Otherwise: `$otp = $otpGenerator->generateOtp();`
    `$otpMailer->sendOtpEmail($email, $otp);`
    `$this->state->set('otp_code_' . $email, $otp);` (Drupal State key-value store, keyed by email).
  - Sets a status message and `$form_state->setRedirect('email_otp_login.validate_otp',
    ['email' => $email])`.

## Step 2 — validate the code: `OtpValidation`

`src/Form/OtpValidation.php`, form id `otp_validation_form`, extends `FormBase`. Injects
`StateInterface`, `EntityTypeManagerInterface`.

- `buildForm()`: a required `password`-type field `otp` plus a submit button.
- `submitForm()`:
  - `$email = $this->getRouteMatch()->getParameter('email');` (from the URL).
  - `$otp_entered = $form_state->getValue('otp');`
  - `$stored_otp = $this->state->get('otp_code_' . $email);`
  - If `$stored_otp !== NULL && hash_equals((string) $stored_otp, $otp_entered)`:
    load the user by `mail`; if found → `user_login_finalize($user)` (establishes the authenticated
    session), `$this->state->delete('otp_code_' . $email)`, status message, and redirect to
    `entity.user.canonical` for that uid. If no user → error "No user found for this email."
  - Else → error "Invalid OTP."

## Mail (`hook_mail`)

`src/Hook/EmailOtpLoginHooks.php` — `#[Hook('mail')] mail()`: for key `otp_email` sets
`$message['subject'] = t('Your OTP Code')` and appends
`$message['body'][] = t('Your OTP code is: @otp', ['@otp' => $params['otp']])`.
`email_otp_login.module` keeps a `#[LegacyHook]` procedural `email_otp_login_mail()` that delegates
to this class (skipped on Drupal 11.1+ in favour of the attribute hook).

## Unrouted controller

`src/Controller/OtpLoginController.php` (`generateOtp()`) emails a fresh code to the *current*
authenticated user and redirects to `user.login`, but no route references it in this release, so it
is not part of the reachable flow.
