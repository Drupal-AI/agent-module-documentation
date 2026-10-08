<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Login Flow — agent index

**Provides plug-in based user authentication** (a `Challenge` plugin framework for multi-step login). Depends on
core `user`. Version **1.0.2**. Core `^10.3||^11`.

Authentication framework — security depends on the **challenge plugins**: ensure they can't be skipped, fail
closed, and are implemented securely (they govern login). Review specific challenges.
