# Smart Date Extra Tokens — manual setup guide

**Smart Date Extra Tokens** (`smart_date_extra_tokens`) extends the token support
that the [Smart Date](https://www.drupal.org/project/smart_date) module (and its
Smart Date Recur submodule) already provide. It fills in a few missing token
replacements for smart-date field values — handy in cases the built-in tokens
don't cover — so you can drop them anywhere tokens are supported.

It works the moment you enable it: **no configuration is required or provided**.
You simply use the new tokens where you'd use any other token. The module adds two
in particular:

- **`value-closest`** — grabs the proper start date for a smart-date or recurring
  field and formats it correctly. For example:
  `[node:field_when:0:value-closest:Y-m-d]`
- **`end_value-closest`** — grabs the closest end date for a smart-date or
  recurring field and formats it correctly. For example:
  `[node:field_when:0:end_value-closest:Y-m-d]`

The `:Y-m-d` part is a standard PHP date format string, so you can format the
output however you like. The module depends only on the Smart Date module and lives
in the Token package. Because tokens simply reflect field values that already
respect access, it has no content or access-control role of its own.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## How to use it

Once enabled, the extra tokens are available anywhere Drupal offers token
replacement — email templates, field formatters, Pathauto patterns, and so on.
Reference a smart-date field on your entity and append `value-closest` or
`end_value-closest` (plus an optional date-format string) as shown above. For
background on the tokens Smart Date already ships, see the
[Smart Date token documentation](https://www.drupal.org/docs/8/modules/smart-date/using-smart-dates-tokens).
