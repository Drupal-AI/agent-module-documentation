# PhoneNumber — manual setup guide

**PhoneNumber** (`phonenumber`) defines a dedicated field type for **international
phone numbers**, backed by the well‑known `libphonenumber` library. Instead of
storing a number as free text, it parses and stores it consistently, offers a
country‑selection widget (with flags and example formats in the placeholder), and
can format the number for display based on the chosen country. Through its
submodules it can also *validate* numbers and *verify* that the person entering one
actually controls it, by SMS.

The base module gives you the field type and the country‑aware widget. Two optional
submodules add the interesting behaviour: **PhoneNumber Validation**
(`phonenumber_validation`) checks that a number is well‑formed and belongs to the
selected country, and **PhoneNumber Verification** (`phonenumber_verification`)
implements the send‑a‑code / enter‑the‑code flow that proves someone answered on the
number.

That distinction is worth being clear about, because the two are easily confused.
*Validation* means the number is well‑formed and could exist. *Verification* means
someone actually answered on it. Only verification is evidence of anything — so if
you need a phone number for account recovery, two‑factor authentication, or simply
to stop users entering someone else's number, it is the verification submodule you
want. Note that verification needs an **SMS gateway**, which is a separate cost and
configuration outside this module, and remember that phone numbers are personal
data with the privacy obligations that implies.

This release is **1.0.0‑beta1** (a beta), and it requires the
`giggsey/libphonenumber-for-php` library, which Composer installs for you.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its library with
   Composer, and enable the submodules you need.

There is **no site‑wide settings page** for this module. You configure it per field
— on the field's own settings and widget/display — as described in "How to use it"
below. (The SMS gateway that verification relies on is configured separately, in
whichever SMS framework you use.)

## How to use it

1. Install the module and enable the submodules you need — start with the base
   module, add **PhoneNumber Validation** for format/country checks, and add
   **PhoneNumber Verification** if you need proof of ownership (see
   [Installation](installation/index.md)).
2. Go to **Structure → Content types → *(your type)* → Manage fields** (or the
   Manage fields screen of any fieldable entity — for example the user account, for
   a profile phone number).
3. Click **Create a new field** and choose the **Phone number** field type.
4. In the field settings, set options such as the **default country** and any
   country restrictions; the widget shows a country selector with flags and an
   example format in the placeholder.
5. If you enabled verification, wire up your SMS gateway (configured in your SMS
   framework) so the field can send a code and require the user to enter it before
   the number is accepted.

> **Watch the "send code" endpoint.** An unthrottled verification endpoint exposed
> to anonymous users is an SMS‑pumping abuse vector (and a per‑message cost). Make
> sure rate limiting is in place before exposing verification publicly.
