<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mother May I requires the user to give a secret word to initiate account creation.

---

Mother May I is an anti-spam gate for user registration — it requires anyone creating an account to
enter a configured secret word/phrase before the registration form proceeds, blocking bots/strangers who
don't know the word. It is configured at `mothermayi.settings`, in the Spam control package.

Use it to gate self-registration behind a shared secret (useful for semi-private communities where new users
are given the word out-of-band). Understand its security model: the secret word is a **shared, low-entropy
gate**, not per-user authentication — it deters casual/automated signups but anyone who learns the word (it
may be shared widely or leak) can register, and it doesn't rate-limit guesses by itself. So treat it as a
lightweight deterrent, pair it with other anti-spam (Honeypot/CAPTCHA/flood control) for stronger protection,
and rotate the word if it leaks. It has no other access-control role. Configure the secret word.

---

- Require a secret word to register.
- Gate account creation.
- Block bots/strangers without the word.
- Configure at mothermayi.settings.
- Serve semi-private communities.
- Share the word out-of-band.
- Understand it's a shared low-entropy gate.
- Know anyone with the word can register.
- Not rely on it as strong auth.
- Pair with Honeypot/CAPTCHA/flood control.
- Rotate the word if it leaks.
- Have no other access-control role.
- Configure the secret word.
- Deter casual signups.
- Gate registration.
- Handle the secret gate.
- Block automated signups.
- Configure the gate.
- Deter spam registration.
- Require the secret.
