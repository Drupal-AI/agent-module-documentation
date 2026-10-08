# Random Coupon Generator — manual setup guide

**Random Coupon Generator** (`random_coupon_generator`) is a small admin module
for bulk-creating large batches of **unique, random coupon codes** for
promotions and campaigns. You define what a code should look like — its length,
character set, an optional prefix and suffix — and the module produces as many
non-sequential codes as you ask for in a single operation.

Under the hood it uses a prime-based obfuscation algorithm (built on the
`wotzebra/unique-codes` package, pulled in automatically via Composer) so the
generated codes are unique and don't run in an obvious sequence. This makes them
harder to guess than a simple counter, though the module is a code *generator* —
it does not itself validate or redeem coupons at checkout, so pair it with your
e-commerce/promotions system for that.

When you generate, you choose how the results come back: printed on the page for
a quick copy-paste, or exported as a downloadable CSV file for import elsewhere.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form (code pattern) and
   the generator form, field by field.

## Where it lives in the admin menu

Both screens sit under **Configuration → System → Random coupon generator**:

- **Settings** — `/admin/config/system/random-coupon-generator/settings`
- **Generate coupons** — `/admin/config/system/random-coupon-generator/generate`
