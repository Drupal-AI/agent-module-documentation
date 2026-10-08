<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CountUp (countup) — agent index

**CKEditor 5 plugin** inserting animated **count-up numbers** into rich text. Version **3.1.0**.
Core `^10.3 || ^11`. Depends on core `ckeditor5`, `editor`.

For animated stats/impact figures (counts from zero on scroll). **Common gotcha:** the text format's
allowed HTML must permit the plugin's inserted element, or the filter strips it on render — the usual
reason such a plugin "doesn't work".