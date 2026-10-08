# geocoder_address — agent start

Geocoder ⇄ contrib **Address** integration. Adds an `Address` preprocessor + `AddressField`
plugin (use an Address field as geocode source/target), an address geocode formatter, and an
`AddressService` that builds a geocodable string from address components using the correct
country format. Configured via **geocoder_field**'s per-field settings. Depends on `address` +
`geocoder_field`.

- What it adds & how to use it → [configure/address.md](configure/address.md)
