<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Registration Limit limits account registration per IP when an account already exists for that IP.

---

Registration Limit **limits registrations per IP** — preventing a new account from being registered from an IP
that already has an account, to curb mass/duplicate account creation. It provides its own permissions.

Use it as an anti-abuse layer on registration. It is an access/anti-spam feature. Understand its limits: it keys on
**IP address**, which is imperfect — shared/NAT/corporate IPs will **block legitimate users** (many people behind
one IP), and attackers can trivially **rotate IPs** (VPN/proxy/botnet) to bypass it. So treat it as one weak
anti-abuse signal, not a real control — combine it with CAPTCHA, email verification and flood control. It has no
broad access-control role beyond its permission. Configure the registration limit.

---

- Limit registrations per IP.
- Block a new account when the IP already has one.
- Curb duplicate account creation.
- Provide its own permissions.
- Serve access/anti-spam.
- Deter mass registration.
- KEY on IP address (imperfect).
- BLOCK legitimate users on shared/NAT/corporate IPs.
- BE bypassable by IP rotation (VPN/proxy/botnet).
- Treat it as one weak signal + combine with CAPTCHA/email verification/flood control.
- Have no broad access-control role beyond permission.
- Configure the registration limit.
- Handle registration limits.
- Limit registrations.
- Configure the limit.
- Block duplicates.
- Handle the IP.
- Deter signups.
- Combine defenses.
- Provide IP-based registration limiting.
