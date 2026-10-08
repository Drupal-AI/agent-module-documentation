<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Reset Password Email OTP lets users reset their password with OTP authentication.

---

Reset Password Email OTP replaces the standard reset-link flow with an **email OTP (one-time password)**
— the user requests a reset, receives an OTP by email, and enters it to set a new password. It depends on core
Block and User, provides its own permissions and a block, in the Security package.

Use it for OTP-based password resets. The OTP is generated with a **CSPRNG** (`random_int`) at a
**configurable length** over a 69-char alphabet, and there is a **wrong-attempt limit**. The stored issuance
`time` is used to pick the latest OTP. Configure OTP length/attempt limit; keep the reset mailflow trustworthy.

---

- Reset passwords via an email OTP.
- Generate the OTP with a CSPRNG.
- Use a configurable OTP length.
- Limit wrong attempts.
- Keep the reset mailflow trustworthy.
- Provide its own permissions and a block.
- Handle OTP reset.
- Configure the OTP.
- Depend on core Block and User.
- Reset via OTP.
- Provide email-OTP reset.
