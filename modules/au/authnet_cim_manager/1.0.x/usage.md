Provides a Drupal form/block that creates Authorize.Net Customer Information Manager (CIM) customer payment profiles from entered credit-card and billing details.

---

AuthNet CIM Manager connects a Drupal site to the Authorize.Net Customer Information Manager (CIM) using the official `authorizenet/authorizenet` PHP SDK. It ships one front-end form — available both as a route (`/authnet-cim-manager/cim-creation-fom`) and as a placeable block ("CIM Creation Form") — that collects customer type, company, credit-card number, expiry, CVV, name, email, phone and billing address. On submit it builds an Authorize.Net `CreateCustomerProfileRequest` (a `CustomerProfileType` with one `CustomerPaymentProfileType`), sends it to the sandbox or production Authorize.Net endpoint, then runs a `ValidateCustomerPaymentProfile` check; if validation fails the freshly created profile is deleted. A separate settings form stores the Authorize.Net API login ID, transaction key and environment. The module keeps no record of the created profile in Drupal and offers no charge, update, list or delete UI — it is purely a "capture card details and create a CIM profile on Authorize.Net" helper.

---

- Let staff capture a customer's card and billing details and create a stored CIM payment profile on Authorize.Net.
- Add a self-service "save my card on file" form to a page by placing the CIM Creation Form block.
- Tokenize a credit card into an Authorize.Net customer/payment profile so raw PAN need not be re-collected later.
- Onboard a customer's payment method during account setup or checkout onto the merchant's Authorize.Net gateway.
- Validate a submitted card is chargeable via Authorize.Net's `liveMode` payment-profile validation as part of profile creation.
- Automatically roll back (delete) a CIM profile whose payment method fails validation.
- Configure Authorize.Net API login ID and transaction key once at `/admin/config/system/authcim`.
- Switch between Authorize.Net sandbox (development) and production processing with a single environment setting.
- Collect a full billing address (company, name, address, city, state, zip, country, phone) alongside the card for AVS purposes.
- Format and lightly validate card number, expiry (mm/yy), CVV and ZIP client-side as the user types.
- Server-side validate that the card number and CVV are digits, the expiry matches mm/yy and is not in the past, and the phone contains only allowed characters.
- Embed the card-capture form inside a landing page, membership page or donation page via block placement.
- Provide a Drupal-native alternative to hosted Authorize.Net order forms for creating CIM profiles.
- Standardize customer profile descriptions and merchant customer IDs (auto-generated as `M_<time>`) on Authorize.Net.
- Use as a starting point / reference for building a fuller CIM integration on top of the Authorize.Net SDK.
- Test Authorize.Net sandbox credentials and connectivity by creating a sample CIM profile.
- Attach a customer email to each created Authorize.Net customer profile for gateway-side receipts/records.
- Capture both individual and business customer types into distinct CIM customer records.
- Give administrators a single config page to rotate the Authorize.Net transaction key when it changes.
