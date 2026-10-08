<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reviews — agent index

Enables **user reviews of content/entities** (rating + text — products/articles). Config at `reviews.settings`;
provides permissions. Version **2.0.0-beta1**. Core `^8||^9||^10||^11`.

**Security:** reviews are **user-submitted content** — sanitize/escape on display (stored-XSS), moderate
(spam/abuse — approval/flood control), gate who submits/moderates; may contain PII. No access role beyond
permission.
