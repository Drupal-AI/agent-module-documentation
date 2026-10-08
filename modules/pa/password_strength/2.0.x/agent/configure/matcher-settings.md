<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# zxcvbn matcher settings (site-wide)

Which zxcvbn matchers contribute to the strength score is controlled globally by one config
object, **`password_strength.settings`**, key `enabled_matchers`. This is separate from the
per-policy `strength_score` — it tunes *how* zxcvbn scores, for the whole site.

- **Route / form:** `password_strength.settings` at
  `/admin/config/security/password_strength/settings`
  (a checkbox per matcher; permission `administer site configuration`). Appears under
  the Password Policy admin index menu.
- **Config object:** `password_strength.settings`

Default `enabled_matchers` (all eight on; each value is the matcher id or empty when off):

```yaml
enabled_matchers:
  zxcvbn_datematch: zxcvbn_datematch            # dates in passwords
  zxcvbn_digitmatch: zxcvbn_digitmatch          # 3+ digits in a row
  zxcvbn_l33tmatch: zxcvbn_l33tmatch            # l33t-speak substitutions
  zxcvbn_repeatmatch: zxcvbn_repeatmatch        # 3+ repeated chars
  zxcvbn_sequencematch: zxcvbn_sequencematch    # alphanumeric sequences
  zxcvbn_spatialmatch: zxcvbn_spatialmatch      # keyboard-spatial patterns
  zxcvbn_yearmatch: zxcvbn_yearmatch            # years
  zxcvbn_dictionarymatch: zxcvbn_dictionarymatch # dictionary words
```

Read/write with Drush:

```bash
drush config:get password_strength.settings enabled_matchers
drush config:set password_strength.settings enabled_matchers.zxcvbn_l33tmatch 0 -y
```

These eight matcher ids are supplied by this module's plugin manager, which augments any
discovered `PasswordStrengthMatcher` plugins with the zxcvbn library's built-in matchers
(see [../plugins/matchers.md](../plugins/matchers.md)).
