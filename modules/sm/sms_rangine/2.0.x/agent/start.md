<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SMS Rangine (sms_rangine) — agent index

Single-plugin **SMS Framework** (`sms`) gateway for the Iranian Rangine SMS service. Version **2.0.0** (dir also carried legacy `8.x-1.3`), core `^9 || ^10`.

**Shape:** one class, `Plugin/SmsGateway/RangineGateway` (`@SmsGateway id="rangine"`). Config keys: user, pass, sender, confirm, host (`sms.rangine.ir`), debug. No routes/services/permissions.

**Send paths:** normal → POST form fields to `{host}/services.jspd`; pattern (body starts `pcode:`/`patterncode:`) → GET `{host}/patterns/pattern?username=&password=...`. Uses raw PHP cURL (`cUrl()`), not Guzzle.

**Security note (report-relevant):** default `host` lacks a scheme → cURL uses plain HTTP, and pattern sends place the Rangine **username and password in the URL query string**. cURL sets no `CURLOPT_SSL_VERIFYPEER` either way. Advise admins to set `host` to `https://…`. Credentials are the site's own outbound account (admin-configured), so exposure is transport-layer, not an anonymous-abuse route.
