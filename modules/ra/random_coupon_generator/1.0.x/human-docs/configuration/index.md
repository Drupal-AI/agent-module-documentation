# Configuration

Random Coupon Generator has two screens: a **Settings** form where you define the
shape of a coupon code, and a **Generate coupons** form where you actually
produce a batch.

## Who can use it

The module defines its own permission for reaching the generator. As an
administrator, go to **People → Permissions**
(`/admin/people/permissions`), find the Random Coupon Generator permission, and
grant it only to trusted roles — generating large batches of codes is a
privileged marketing/admin action.

## Settings form

**Configuration → System → Random coupon generator → Settings**
(`/admin/config/system/random-coupon-generator/settings`)

This is where you define what a code looks like. The fields:

- **Length** — how many characters each generated code has. Longer codes give a
  far larger pool of possible values, which matters if you plan to generate many
  codes (see the note on uniqueness below).
- **Character set** — which characters may appear in a code (for example digits
  only, or upper-case letters plus digits). A wider character set also enlarges
  the pool of possible codes.
- **Prefix** and **Suffix** — optional fixed text added to the front and/or back
  of every code, handy for branding a campaign (e.g. `SUMMER-XXXXXX`).
- **Obfuscation / max primes** — advanced settings that tune the prime-based
  algorithm that spreads codes out so they are non-sequential and hard to guess.
  The defaults are sensible; only change these if you understand the underlying
  algorithm.

Click **Save configuration** to store these defaults.

> **A note on uniqueness and predictability.** The module generates *unique,
> non-sequential* codes, which makes them much harder to guess than a plain
> counter. But the size of the guessable space depends entirely on your **length**
> and **character set**: short, digits-only codes are quicker to brute-force. If
> the codes gate real discounts, choose a generous length and a wide character
> set, and rely on your redemption system to rate-limit and enforce one-time use.

## Generate coupons form

**Configuration → System → Random coupon generator → Generate coupons**
(`/admin/config/system/random-coupon-generator/generate`)

Here you produce a batch using the pattern from the Settings form. You typically
set:

- **How many codes** to generate in this run — the module is built to create
  large quantities in a single operation.
- **Output method** — choose between:
  - **Show on the page** — the codes are listed on screen, ready to copy.
  - **Download as CSV** — the codes are streamed to a CSV file you can save and
    import into another system.

Submit the form to generate. For very large batches, prefer the CSV download so
the results don't have to render on the page.
