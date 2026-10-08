<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Log Middleware lets modules wrap Drupal's logger with middleware for cross-cutting log handling.

---

Log Middleware adds support for middleware to Drupal's logger — a mechanism letting modules insert cross-cutting handling (enrichment, filtering, routing) around log messages via a middleware pattern, rather than each logger reimplementing it. It's developer infrastructure for structured logging.

It's a developer/logging framework with no content or access role of its own; because log messages can contain sensitive data, middleware that forwards logs should be configured with care. Supports Drupal 10.3+ and 11.

---

- Add middleware to the logger.
- Wrap log handling cross-cuttingly.
- Enrich/filter/route log messages.
- Use a middleware pattern.
- Avoid per-logger reimplementation.
- Provide logging infrastructure.
- Handle sensitive log data with care.
- Configure forwarding middleware carefully.
- Support Drupal 10.3+ and 11.
- Carry no content/access role.
- Act as a developer framework.
- Structure logging.
- Insert log middleware
- Support log processing.
- Underpin logging modules.
- Aid developers.
- Process logs consistently.
- Extend the logger
