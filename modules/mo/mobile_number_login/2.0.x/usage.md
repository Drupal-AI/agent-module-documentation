<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mobile Number Login lets users log in with a mobile number.

---

Mobile Number Login **lets users log in with their mobile number** — enabling phone-number-based
authentication (typically confirmed by an SMS one-time code) as an alternative to username/email login. It is in
the Mobile package.

Use it to offer phone-based login. It is an authentication feature and it is **security-sensitive**: phone login
relies on **SMS OTP verification**, so it must use a **cryptographically random, single-use, expiring** code with
**flood/rate-limiting** on both sending (to prevent SMS-bombing/cost abuse) and verification (to prevent code
brute-force) — this typically comes from the underlying mobile-number/SMS layer, so verify that flood control and
proper verification are in place in your setup. Store the SMS-gateway **credentials** as secrets. It layers on
core authentication. Configure the phone-login and SMS settings.

---

- Log in with a mobile number.
- Authenticate by phone.
- Confirm with an SMS OTP.
- Serve the Mobile package.
- Serve authentication.
- Offer phone login.
- REQUIRE a random, single-use, expiring OTP.
- Flood/rate-limit sending AND verification.
- Prevent SMS-bombing + code brute-force.
- Store SMS-gateway credentials as secrets.
- Verify flood control + verification are in place.
- Layer on core authentication.
- Handle phone login.
- Authenticate users.
- Configure the phone login.
- Log users in.
- Handle the OTP.
- Verify phones.
- Secure the flow.
- Provide mobile-number login.
