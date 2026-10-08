<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mobile Number Login — agent index

Lets **users log in with their mobile number** (phone auth, typically via SMS OTP). Version **2.0.0**. Core
`^10.1||^11||^12`.

Authentication — **security-sensitive**: needs a random/single-use/expiring OTP with **flood-limiting** on
sending (SMS-bombing) AND verification (brute-force); verify this in your setup; SMS-gateway credentials as
secrets. Layers on core auth.
