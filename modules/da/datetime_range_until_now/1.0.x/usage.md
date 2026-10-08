<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DateTime Range Until Now adds an "Until now" option to core's Date Range field, so a period that started and has not ended is stored as an explicit third state instead of a blank or fake end date.

---

Install it with `composer require drupal/datetime_range_until_now` and enable it (`drush en datetime_range_until_now`); it depends on core's **Datetime Range** module, which must also be on. It needs no configuration page. On any content type add or reuse a **Date range** field, then on the field's **Field settings** (storage) tick **"Provide until now"** to switch the option on — the module also rebinds the core Date Range widget and formatter, so existing Date Range fields pick up the feature too, and its install step migrates their database columns automatically. When editing content you now see an **"Until now"** checkbox next to the range; tick it to mark the period ongoing and the end date becomes optional. On **Manage display** the field's default formatter renders it as `start` + a separator + **"Until now"** (the separator, default `-`, is configurable in the formatter settings). Because "now" is evaluated when the field is rendered rather than when it is saved, an ongoing value is a live statement, and the value is stored with a real `until_now` flag so it is never confused with an empty end date. A separate `daterange_until_now` field type is also available if you prefer to add a fresh field explicitly.

---

- Show a role as ongoing on a CV.
- Mark a project as still running.
- Express a current membership.
- Show an exhibition still open.
- Record an employment period to present.
- Avoid a far-future placeholder date.
- Distinguish ongoing from unfilled.
- Show a course still in progress.
- Record a continuing appointment.
- Display "2019 – present".
- Mark a campaign as active.
- Record an open-ended contract.
- Show a service still offered.
- Express an unended tenure.
- Record a continuing partnership.
- Show a subscription still active.
- Avoid a separate current checkbox.
- Retrofit the option onto existing Date Range fields.
- Make the end date optional on ongoing entries.
- Model an open-ended period properly.
