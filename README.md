# README

This app accepts a json from external then extract the json to a ticket and an excavator.
We can view list of created tickets using `/tickets` and details of a ticket using `/tickets/:id`.

`POST /api/v1/tickets`: It accepts `json` parameter, the value of `json` parameter is a json string. It will return bad request error if the `json` parameter is empty.

```
curl -d 'json={"ContactCenter": "UPCA", "RequestNumber": "09252012-00001", "ReferenceRequestNumber": "", "VersionNumber": "0", "SequenceNumber": "2421", "RequestType": "Normal", "RequestAction": "Restake", "DateTimes": { "RequestTakenDateTime": "2011/07/02 23:09:38", "TransmissionDateTime": "", "LegalDateTime": "2011/07/08 07:00:00", "ResponseDueDateTime": "2011/07/13 23:59:59", "RestakeDate": "2011/07/21 00:00:00", "ExpirationDate": "2011/07/26 00:00:00", "LPMeetingAcceptDueDate": "", "OverheadBeginDate": "", "OverheadEndDate": ""}, "ServiceArea": {"PrimaryServiceAreaCode": {"SACode": "ZZGL103" }, "AdditionalServiceAreaCodes": {"SACode": ["ZZL01", "ZZL02", "ZZL03" ]}}, "Excavator": { "CompanyName": "John Doe CONSTRUCTION", "Address": "555 Some RD", "City": "SOME PARK", "State": "ZZ", "Zip": "55555", "Type": "Excavator", "Contact": {"Name": "Johnny Doe", "Phone": "1115552345", "Email": "example@example.com" }, "FieldContact": {"Name": "Field Contact", "Phone": "1235557924", "Email": "example@example.com" }, "CrewOnsite": "true" }, "ExcavationInfo": { "TypeOfWork": "rpr man hole tops", "WorkDoneFor": "gpc", "ProjectDuration": "60 days", "ProjectStartDate": "2011/07/08 07:00:00", "Explosives": "No", "UndergroundOverhead": "Underground", "HorizontalBoring": "Road, Driveway, and Sidewalk", "Whitelined": "No", "LocateInstructions": "locate along the r/o/w on both sides of the rd - including the rd itself - from inter to inter ", "Remarks": "Previous Request Number:05161-120-011\n\n\t\t\tPrevious Request Number:06044-254-020\n\n\t\t\tPrevious Request Number:06171-300-030", "DigsiteInfo": {"LookupBy": "MANUAL", "LocationType": "Multiple Address", "Subdivision": "", "AddressInfo": { "State": "ST", "County": "COUNTY", "Place": "PLACE", "Zip": "", "Address": {"AddressNum": ["Address 1", "Address 2"]}, "Street": {"Prefix": "", "Name": "Trinity", "Type": "Ave", "Suffix": "SW"}}, "NearStreet": {"State": "XX", "County": "SomeCounty", "Place": "City", "Prefix": "", "Name": "", "Type": "", "Suffix": ""}, "Intersection": {"ItoI": [{"State": "XX", "County": "FULERTON", "Place": "NORCROSS", "Prefix": "", "Name": "London", "Type": "St", "Suffix": "SW"}, {"State": "ZZ", "County": "COUNTY", "Place": "ATLANTA", "Prefix": "", "Name": "Jefferson", "Type": "Ave", "Suffix": "SW"}]}, "WellKnownText": "POLYGON((-81.13390268058475 32.07206917625161,-81.14660562247929 32.04064386441295,-81.08858407706913 32.02259853170128,-81.05322183341679 32.02434500961698,-81.05047525138554 32.042681017283066,-81.0319358226746 32.06537765335268,-81.01202310294804 32.078469305179404,-81.02850259513554 32.07963291684719,-81.07759774894413 32.07090546831167,-81.12154306144413 32.08806865844325,-81.13390268058475 32.07206917625161))"}}}' -H "Content-Type: application/x-www-form-urlencoded" -X POST http://localhost:3000/api/v1/tickets
```

`GET /tickets` will display created tickets

`GET /tickets/:id` will display the specified ticket with its excavator. if the value of `ExcavationInfo->DigsiteInfo->WellKnownText` of the submitted json is similar to this `POLYGON ((lng lat, lng lat, lng lat,...))` for example `POLYGON ((-88.747078 42.83492, -88.747147 42.830885, -88.739492 42.83055, -88.737421 42.832497, -88.737367 42.83501, -88.747078 42.83492))`, we will display a map and a polygon above the map.

* Ruby version: 2.4

* System dependencies: Rails 5.1, PostgreSQL 9.5+