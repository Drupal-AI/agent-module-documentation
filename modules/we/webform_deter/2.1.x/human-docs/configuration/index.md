# Configuration

Webform Deter has one settings form. Until you add at least one pattern here,
the module does nothing — so this page is where you actually put it to work.

## Open the settings form

1. Log in as a user with the **Administer webform_deter** permission (an
   administrator by default; this permission is marked as security‑sensitive).
2. Go to **Configuration → System → Webform Deter settings**, or navigate
   directly to `/admin/config/system/webform_deter/settings`.

The form has two fields.

## Warning message

A **textarea** holding the text shown in the browser's confirmation pop‑up when
a field matches one of your patterns. The module ships with a helpful default
message, but you can reword it to reassure visitors and tell them what to do —
for example, "It looks like you may be entering sensitive personal information.
Please remove it before submitting." One small technical note: the JavaScript
only activates when this message is longer than a single character, so do not
blank it out.

## Patterns

A **textarea** where you enter your detection patterns, **one per line**. Each
line is a JavaScript regular expression (just the pattern itself — no surrounding
slashes). When the form is saved, blank lines are dropped and each remaining line
is trimmed and stored as a list. Matching is always **case‑insensitive**, so a
pattern written as `ssn` also catches `SSN`.

The list starts empty. Add the patterns that describe the sensitive data you
want to catch. Some examples drawn from the module's own documentation:

| Goal | Example pattern |
|---|---|
| Social Security number | `[\d\-]{9,11}` |
| Keyword hint for SSNs | `(ssn|social security number)` |
| Credit card number | `[\d \-]{13,19}` |
| Keyword hint for cards | `(card number|credit card)` |
| Date of birth keywords | `(dob|birthday|date of birth)` |
| Driver's license (9 digits) | `\d{9}` |

Because these are broad patterns tested against every text field, expect some
false positives — that is by design for a gentle "are you sure?" deterrent.

## Save

Click **Save configuration**. The new message and patterns take effect
immediately: every text field and textarea on every webform is tested on submit,
and a match pops up your warning. If the visitor cancels, that one submission is
blocked and the check is removed, so a corrected resubmit goes straight through
without nagging them again.

## Setting values from the command line

You can also set these values with Drush instead of the form:

```bash
ddev drush cset webform_deter.settings warning_message "Please do not submit sensitive data." -y
ddev drush cset webform_deter.settings patterns.0 '\d{3}-\d{2}-\d{4}' -y
```
