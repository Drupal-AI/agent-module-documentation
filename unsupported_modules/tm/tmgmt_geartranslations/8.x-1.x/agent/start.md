<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GearTranslations Translator — agent index

**GearTranslations translator plugin for TMGMT**. Version **8.x-1.3**. Core `>=8`.

**SECURITY (8.x-1.3):** `/tmgmt_geartranslations_callback` (`_access: TRUE`) imports posted `texts` into any active job with NO signature check → anonymous translation-content injection / possible stored XSS; API connector sets `CURLOPT_SSL_VERIFYPEER=false` (leaks the Access-Token, MITM). Verify signatures + enable TLS. Depends on `tmgmt`/`tmgmt_content`.