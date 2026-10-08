<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# date_recur_ss — agent orientation

Alternative Date Recur **interpreter** plugin (RRULE → human-readable text). Depends on `date_recur` >= 3.2, PHP 8.0+.

- Single plugin: `src/Plugin/DateRecurInterpreter/SsInterpreter.php`. Pure formatting.
- No routes/perms/DB/external calls — no security surface.
- Selected via Date Recur's interpreter config and used in field formatters.
