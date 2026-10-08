<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# carryquery — agent orientation

- Carries URL query-string parameters forward and exposes them as tokens (integrates token + token_filter + filter).
- Admin config form `src/Form/QredirectConfig.php` at `admin/config/carryquery` (`administer site configuration`); config object `carryquery`.
- No anonymous or state-changing endpoints; token output goes through token_filter's sanitisation. No security finding.
- Has tests/, JS, services.yml, menu link.
