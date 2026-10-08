<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Cache Debug loggers

Route `cache_debug.admin.settings` → `/admin/config/development/cache-debug`, permission `configure cache debug`.

- **Response logger** (`response_logger`) — plugin recording the cache tags of each main-request cacheable response (`LogCacheTagsSubscriber` on `KernelEvents::RESPONSE`).
- **Invalidated logger** (`invalidated_logger`) — plugin recording cache tags as they are invalidated (`InvalidatedCacheTagsLogger`, tagged `cache_tags_invalidator`); also captures drush/CLI invalidations via `argv`.
- **File log path** (`log_path`, default `private://cache_debug`) — where the File plugin writes; keep it in the private scheme.

Built-in plugins: `file`, `logger_channel` (watchdog), `sentry` (needs the Raven module). Set either logger to none (`_none`) to disable. Cache tags are written only to the chosen sink — never to HTTP response headers.
