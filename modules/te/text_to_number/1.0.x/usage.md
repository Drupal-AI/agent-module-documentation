<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Text To Number provides an alternate widget for integer fields that lets editors type text such as "Missing" or "No value" and stores it as NULL rather than coercing it to zero.
---
By default a number field widget forces numeric input, so a blank or non-numeric entry becomes 0, which is indistinguishable from a genuine zero. This module registers a `text_to_number_text` field widget (for the core `integer` field type) that renders a plain textfield (size 20, maxlength 30) with a "Missing" placeholder. An element validate callback then normalizes the input on submit: an empty string is stored as empty, the literal `Missing`/`missing` is stored as NULL, and any other value is stripped to digits only with `preg_replace("/[^0-9]/", "", $value)` before saving.

The module has no configuration UI, routes, permissions, or services beyond the widget itself (which offers a single "Size of textfield" setting). To use it, edit an integer field's form-display and choose the "Text to Number" widget. Note the digit-stripping is not a negative-number-aware parse (a minus sign is removed), so it suits non-negative counts where distinguishing "unknown" from zero matters.
---
- Distinguish "unknown/missing" from a real 0 on an integer field
- Let editors type "Missing" and store NULL instead of zero
- Accept loosely formatted numeric input and strip it to digits
- Show a "Missing" placeholder on empty integer inputs
- Record NULL for survey/data fields that were not answered
- Import-friendly manual entry where blanks must stay empty
- Avoid false zeros skewing averages or reports
- Apply the widget on any integer field via Manage form display
- Configure the textfield size per field instance
- Keep counts non-negative by stripping non-digit characters
- Provide a friendlier free-text entry for numeric fields
- Store empty string when the editor clears the value
- Use on user/profile integer fields that may be intentionally blank
- Use on node integer fields where 0 is a meaningful value
- Normalize pasted values (e.g. "12 items" -> 12) on save
