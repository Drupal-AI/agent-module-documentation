<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Age Exposed Filter provides a Views exposed filter that filters on a computed age from a date field, so users can filter by age rather than by raw date.

---

A date-of-birth field stores a date, but people think in ages: "show members over 65", "applicants aged 18–25". Filtering a Views listing by a raw date range to express an age is awkward and inverts as time passes. Age Exposed Filter computes the age from a date field and exposes it as a Views filter, so the exposed control is an age (or age range) and the module translates it to the underlying dates.

It works on date fields in Views and is a UI/query convenience with no security surface of its own — it filters what the view already exposes. The natural caveat is that age derived from a date of birth is personal data, so a public listing filterable by age is exposing an attribute of real people; that is a data-modelling and privacy decision about the view, not a flaw in the filter.

For directories, membership listings, and any content where age is the meaningful axis, it is the right control. Confirm the view's access and what it exposes, since filtering by age on a public view surfaces an inferred personal attribute.

---

- Filter a view by age.
- Show members over a certain age.
- Filter applicants by age range.
- Compute age from a date field.
- Expose an age filter in Views.
- Filter by age not date.
- Provide an age range control.
- Filter a directory by age.
- Translate age to date range.
- Handle date-of-birth filtering.
- Filter membership by age.
- Avoid inverting date logic.
- Expose an age band.
- Consider age as personal data.
- Confirm the view's access.
- Filter records by computed age.
- Provide an intuitive age control.
- Filter by age in a listing.
- Show an age-restricted list.
- Query on derived age.