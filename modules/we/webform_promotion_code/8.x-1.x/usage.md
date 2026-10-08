<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Promotion Code adds a Webform text element that rejects a submission unless the value typed matches one of an admin-configured list of valid codes.

---

The module registers a single Webform element, `webform_promotion_code`, rendered as an ordinary `<input type="text">`. Its element-configuration form (fieldset "Promotion code settings") holds a `codes` textarea — one valid code per line — plus three helper properties (`amount`, `code_length`, `code_pattern`) that drive a client-side "Auto generate" button which fills the textarea with random codes (the button and generation run entirely in JavaScript on the admin form; they do not affect validation). At submit time the element's `#element_validate` callback trims the submitted value, splits the stored `#codes` string on newlines into an array, and calls `in_array()` — a case-sensitive, non-constant-time membership test. A non-empty value that is not in the list produces the error "*<title>* must be a valid code."; an empty value passes (the element is optional unless you also mark it required). There is **no database table, no state, no entity, and no config schema** — the code list lives as a plaintext property inside the Webform's own element configuration (and therefore inside any config export / version control). Critically, the element only *validates*; it never records that a code was used, so **a valid code can be redeemed on unlimited submissions**. To enforce single use you must separately turn on Webform's built-in **Unique** value constraint on the element, which rejects a code that already appears in a prior submission of that form. The module ships no routes, permissions, hooks, services, Drush commands, or submodules; requires the `webform` module; and works on Drupal 9, 10, and 11.

---

- Gate an anonymous Webform behind an invitation/access code so only code holders can submit.
- Add a voucher or promotion-code field to a signup form.
- Apply a partner or campaign discount code as an entry requirement.
- Password-protect a Webform without user accounts.
- Restrict a survey to invited participants.
- Validate a conference speaker or attendee code.
- Gate a members-only booking or reservation form.
- Validate an access code for a training course or download.
- Restrict a competition or giveaway entry to code holders.
- Validate a referral code on a lead form.
- Auto-generate a batch of random one-off codes from the element config screen.
- Distribute unique codes and enforce single use by pairing the element with Webform's "Unique" setting.
- Check a membership code before allowing an RSVP.
- Add a campaign code field to an event registration.
- Gate a whitepaper/download request form behind a code.
- Validate an early-access beta code.
- Require a valid coupon string before a Webform-driven order request.
- Screen out anonymous spam by requiring a shared secret code.
- Restrict a feedback form to a known cohort via a shared code.
- Verify an invitation token pasted from an email.
