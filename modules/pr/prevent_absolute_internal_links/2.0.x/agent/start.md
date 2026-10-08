<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prevent absolute internal links — agent index

Validates **link fields to ensure internal links are relative/proper** (not hard-coded absolute URLs) —
avoids domain hard-coding that breaks across environments. Version **2.0.1**. Core `^9||^10||^11`.

Content-editing/validation — validates link input on save; no access change (portability/correctness
benefit).
