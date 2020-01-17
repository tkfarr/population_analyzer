# PeerStreet Coding Challenge

## Intro

Hi! Thanks for applying at PeerStreet and taking the time to take on this coding challenge. We believe it’s very important to evaluate every candidate’s technical ability, but we also want to simulate a realistic challenge and environment you may encounter at our office. Optimizing algorithms on a whiteboard under a time constraint isn’t usually the case. As such, we’d like to give you an opportunity to work at your own pace on a problem that is actually relevant to PeerStreet and then discuss your solution during the onsite.

## Overview

The use of publicly available data is crucial in helping PeerStreet make better decisions when underwriting real estate loans as well as complying with the requirements of some of our partners. In this project, you will use the US Government’s HUD & Census data to build a small API for retrieving population growth based on a zip code.

## Input Data

1. [Zip to CBSA (csv)](https://s3.amazonaws.com/peerstreet-static/engineering/zip_to_msa/zip_to_cbsa.csv)
1. [CBSA to MSA (csv)](https://s3.amazonaws.com/peerstreet-static/engineering/zip_to_msa/cbsa_to_msa.csv)

## Examples

*Note: the following is presented for readability, not as expected API output*

```yaml
Zip: 90266
CBSA: 31084
MSA: Los Angeles-Long Beach-Anaheim, CA
Pop2015: 13,340,068
Pop2014: 13,254,397
```

```yaml
Zip: 32003
CBSA: 27260
MSA: Jacksonville, FL
Pop2015: 1,449,481
Pop2014: 1,421,004
```

```yaml
Zip: 88340
CBSA: 10460
MSA: N/A
Pop2015: N/A
Pop2014: N/A
```

```yaml
Zip: 88338
CBSA: 99999
MSA: N/A
Pop2015: N/A
Pop2014: N/A
```

## Zip to MSA

### Step 1: Find CBSA from Zip

The first file below will allow you to map a zip code to a CBSA (Core Based Statistical Area). Columns 1 (ZIP) and 2 (CBSA) are self-explanatory. If the CBSA is 99999, the zip code is not part of a CBSA.

### Step 2: Check for Alternate CBSA

The second file will allow you to map a CBSA to a MSA (Metropolitan Statistical Area) and retrieve the output necessary for the API. This one is a bit more tricky, however. Look up the CBSA provided by the Step 1 in Column 2 (MDIV). If present, then use the corresponding CBSA in Column 1 going forward. If not found, then continue to use that of Step 1.

*Example: For zip code 90266, the CBSA in the first file is 31084. This value is not present in Column 1 (CBSA), but only in Column 2 (MDIV) of the second file. The corresponding CBSA value is actually 31080 and you would use that to find the row where `LSAD` = `Metropolitan Statistical Area`.*

### Step 3: Retrieve Population Estimates

Using the second file, look up the row where CBSA from the previous step is in Column 1 (CBSA) and Column 5 (LSAD) is equal to `Metropolitan Statistical Area`. If found, extract the values from columns POPESTIMATE2015 and POPESTIMATE2014. In addition, extract the name of the MSA from Column 4 (NAME).

* MSA Name (Col: NAME)
* Population 2014 (Col: POPESTIMATE2014)
* Population 2015 (Col: POPESTIMATE2015)

You should assume that the data import will need to happen again sometime in the future as the population numbers get updated.

## API

#### Basic requirements

* Method: `GET`
* Input Variable Name: `zip`
* Authentication: `none`
* Output format: `json`

#### Input

5 digit zip code.

Examples: `90266`, `10000`, `00001`

#### Output

The output of a successful API call should include the following:

* The input zip code.
* The matching CBSA code.
* The matching MSA name.
* The MSA's population for 2015
* The MSA's population for 2014

The schema is up to you.

## Ruby Client

Make a Ruby client for accessing your API. The requirements for this are open-ended, so please use your own judgement. There is no right answer that we are looking for here as every approach has its pros and cons. You will have an opportunity to discuss your choices later during the onsite.

## Hosting

Please deploy your code to the host of your choice and make its endpoint publicly available for us to evaluate.

## Language selection

Feel free to use the language you're most comfortable to demonstrate your ability to build APIs. For the client, however, we do insist that you use Ruby.

## Deliverables

To accomplish this project you will have to write code to:

1. Process the input files
1. Deliver the output via an API
1. Retrieve the output via a Ruby client

As your deliverable to PeerStreet, please provide:

1. All code that you produced uploaded to this repo
1. Publicly accessible endpoint to the API
