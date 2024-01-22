# Find-CredentialExposureByDomain
Search the Recorded Future Identity module API for exposed credentials related to a specific domain

Returns list of login/username values and when available, the corresponding domain used

---

**Parameters**

_Domain_

[Mandatory]

The domain name to search for

---

**Examples**

```powershell
Find-CredentialExposureByDomain -Domain example.com
```
