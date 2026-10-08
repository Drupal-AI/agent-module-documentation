<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Null Authentication — agent index

**Auth provider that forces a request to anonymous** (`?_null_auth=1`). Version **2.x-dev**. Core `^8..^11`.

Safe: only downgrades to anonymous (`getAnonymousUser()`) — never elevates/impersonates. Development/testing tool.