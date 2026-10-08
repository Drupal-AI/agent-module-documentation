<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Registration codes lets a site require, accept, or optionally accept a code during user registration, with tools to generate, list, and bulk-manage those codes.

---

Registration codes sits between open self-registration (which invites spam) and closed registration (where an administrator creates every account). It adds a single text field to the core user registration form; when that field is required, only visitors who supply a valid, active, unexpired code can complete signup. Codes are stored in a dedicated `regcode` database table with per-code creation, activation (`begins`), expiry (`expires`), active flag, and a use counter versus a maximum-uses limit — so a code can be single-use, multi-use, or unlimited, and can be scheduled to switch on or off by date.

Codes are created one at a time or generated in bulk from the admin UI (`/admin/config/people/regcode/create`) or via Drush (`regcode:generate`), in letters / numbers / alphanumeric / hexadecimal formats. Because the project depends on core Views, the code listing at `/admin/config/people/regcode` is a View (`views.view.regcode`) that can be filtered, sorted, and exported like any other listing; with Views Bulk Operations present it also exposes activate / deactivate / delete bulk actions. The module ships a `registration_code` service (interface `RegistrationCodeInterface`) covering load, validate, consume, save, clean, and generate, plus a `hook_regcode_used()` hook and a `RegcodeUsedEvent` (event name `regcode.code_used`, also a Rules event) so other modules can react when a code is redeemed — for example to assign a role or group. A URL can pre-fill the field via `?regcode=XYZ` on the registration page. Tokens for code fields (`[regcode:code]`, `[regcode:expires]`, …) are provided for use by reacting modules.

Common uses:

---

- Require a valid registration code before any new account can be created.
- Run an invitation-only signup while keeping registration self-service.
- Make the code field optional so codes are accepted but not mandatory.
- Give conference or event attendees a personal signup code.
- Restrict registration to a beta cohort or partner organisation.
- Sell "medallion" / membership codes that entitle the buyer to register.
- Issue promotional or campaign signup codes.
- Generate codes in bulk (choose length, format, and uppercase) from the UI or Drush.
- Create a single specific code with a chosen string and use count.
- Make a code single-use (maxuses = 1) or unlimited (maxuses = 0).
- Schedule a code to activate on a future date (`begins`).
- Expire codes automatically after a date (`expires`).
- List, filter, sort, and export codes through the built-in View.
- Bulk activate, deactivate, or delete codes with Views Bulk Operations.
- Delete all codes, all expired codes, or all inactive codes from the manage form.
- Pre-fill the registration code from a link using `?regcode=CODE`.
- Validate a code from the command line with `drush regcode:validate`.
- Consume/attribute a code to a user from the command line with `drush regcode:consume`.
- React to code redemption via `hook_regcode_used()` or the `RegcodeUsedEvent`.
- Trigger a Rules reaction on the "User has used a registration code" event.
- Assign a role or group membership downstream when a specific code is used.
- Use `[regcode:*]` tokens (code, expires, uses, …) in reacting-module output.
- Customise the field label and help text shown on the registration form.
- Audit which user last redeemed each code through the `uid`/`lastused` columns.
