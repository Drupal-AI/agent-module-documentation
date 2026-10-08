<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LMS Classes (lms_classes) — agent index

Submodule of **lms**. Organises students into **classes** so one course runs for several cohorts.
Version **1.1.18**. Core `^10.3 || ^11`. Depends on `lms`.

**Course = content; class = a delivery of it.** Without the distinction, either the course is
duplicated per cohort (and diverges) or everyone sits in one pool (and reporting is useless).

Makes cohort questions answerable: who has not finished module three, how the autumn intake
compared with spring, who is in this class at all.

Fits **Group**'s membership and access model rather than adding a second one — relevant when
planning who may see whose progress.