# Configuration

The module does nothing on its own — the registration-code field only appears once
you have added at least one code and switched the feature on. You can add either a
single code or several.

## Open the management form

1. Log in as an administrator (or a user with the module's management permission).
2. Go to **Configuration → Manage secret registration code**, or navigate directly
   to `/admin/config/ssrc`.

## Add a code and enable it

Following the on-screen form:

1. **Add a secret code.** Enter the code (or codes) that will be accepted on the
   registration form. You can add more than one — useful if you want to hand
   different groups their own code.
2. **Enable Secret Registration Code.** Turn the feature on so the field is added
   to the registration form.
3. **Save.**

After saving, every anonymous visitor will see a **Registration code** field on the
user registration page and must enter a valid code to complete registration.

## Choosing and looking after the code

Because the code is a shared secret, its strength *is* your protection:

- **Make it strong and non-guessable.** A short or obvious code is easily brute-
  forced or shared around, which defeats the purpose.
- **Rotate it.** Change it periodically, and immediately if you suspect it has
  leaked. Because you can hold multiple codes, you can add a new one before
  retiring an old one.
- **Don't expose it publicly.** Anywhere the code appears in public is a way past
  the gate.
- **Don't rely on it alone.** Combine it with Drupal's core registration
  protections — email verification, administrator approval, flood control, and a
  CAPTCHA — so the code is one layer among several rather than the only barrier.
