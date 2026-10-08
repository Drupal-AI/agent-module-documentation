<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lupus Decoupled Contact (lupus_decoupled_contact) — agent index

Submodule of **lupus_decoupled**. Core **contact forms** in the decoupled front end.
Version **1.5.1**. Core `^10 || ^11`.

Keeps recipients configurable **in Drupal** (not in front-end config the owners cannot reach), and
keeps core's flood control.

**Launch check to state:** verify mail actually sends through the real path. A contact form that
silently fails is the classic launch defect and is invisible from the front end, because the
submission looks successful.