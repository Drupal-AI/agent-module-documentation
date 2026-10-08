<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds an "experience" field type that captures work experience as years plus months, stores it as a single integer number of months, and renders it as text like "02 Year(s) 07 Month(s)".

---

Experience is a small, self-contained Field API module (package "Field types") that depends only on core's Field module and works on Drupal 8 through 11. It defines one field type, `experience` (class `ExperienceItem`), whose storage is a single unsigned integer column holding the total number of months. Data entry uses the `experience_default` widget (`ExperienceDefaultWidget`): two select lists, one for years and one for months (0-11), which are combined on submit into `year * 12 + month`. Per-field settings let you configure the selectable year range (`year_start`/`year_end`, 0-99), whether the year list offers a "Fresher" option (value 0), and whether the "Year"/"Month" labels sit above the selects or are inserted within them as the first option. Two formatters display the stored value: `experience_default` (`ExperienceDefaultFormatter`) shows "X Year(s) Y Month(s)" (or "Fresher" for 0), and `experience_month` (`ExperienceMonthFormatter`) shows the raw month count as "N Month(s)". The module integrates with Views through `experience_field_views_data()` and the `ExperienceFilter` numeric filter plugin, which reuses the year/month select UI for building and exposing filters. It ships no routes, permissions, services, entities or settings page; configuration is done entirely through the Field UI and Views UI, and a small bundled JavaScript library (`experience/drupal.experience`) hides the month select when "Fresher" is chosen.

---

- Capture a candidate's total work experience as structured years + months on a job-application content type.
- Add a "years of experience" field to user profiles during registration on a job portal.
- Record role-relevant / domain-specific experience on a résumé or profile entity.
- Store experience as a single integer month count so it sorts and filters as a number.
- Offer applicants a "Fresher" option for zero experience instead of forcing them to enter 0.
- Constrain the selectable year range (for example 0-30) to keep the widget's dropdown tidy.
- Let editors pick years and months from select lists rather than typing free-text durations.
- Display experience consistently as "02 Year(s) 07 Month(s)" across nodes, users, and listings.
- Show a compact month-only figure (for example "31 Month(s)") using the Month formatter.
- Choose whether the "Year"/"Month" labels appear above the selects or inside them as placeholders.
- Build a View of applicants filtered by a minimum or exact amount of experience.
- Expose an experience filter on a search page so visitors can narrow candidates by seniority.
- Use greater-than / less-than / between operators on experience via the Views numeric filter.
- Sort a candidate listing by experience (highest first) because the value is stored numerically.
- Add the field to paragraphs, taxonomy terms, or any fieldable entity, not just nodes.
- Set a default experience value on a field so new content is pre-populated.
- Collect multiple experience entries per entity by making the field unlimited-cardinality.
- Standardise how experience is recorded and shown across several content types on one site.
- Migrate a free-text "years of experience" field to a structured, filterable numeric field.
- Combine the experience filter with other Views filters (skills, location) for candidate matching.
- Keep the site dependency-free: the field type requires nothing beyond core Field (and Views for filtering).
