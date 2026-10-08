<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Response Code Conditions — agent orientation

Single plugin `src/Plugin/Condition/ResponseCodeCondition.php` (id `response_code`), injects
`request_stack`. `evaluate()`: returns TRUE if no codes configured; else returns FALSE unless the
current request has an `exception` attribute, then compares
`$request->attributes->get('exception')->getStatusCode()` against the newline-separated config
list. Config form has one `response_codes` textarea. Supports core `negate`.

Security review (sound): read-only visibility condition; no routes, no user input beyond admin
config, no data access. No finding.
