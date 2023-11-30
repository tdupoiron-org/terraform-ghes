const core = require('@actions/core');
const { getDomains, getRecords, getRecord, updateRecord, createRecord } = require('./ovh-utils');

async function update(domain, subdomain, ip) {
  try {
    const domains = await getDomains();
    const foundDomain = domains.find((d) => d === domain);
    if (!foundDomain) {
      throw new Error(`Domain ${domain} not found.`);
    }
    core.info(`Found domain ${foundDomain}`);
  
    const records = await getRecords(foundDomain);
    var foundRecordId = undefined;
    var foundRecord = undefined;
    // For each record get the record and check if it matches the subdomain and is an A record
    for (const recordId of records) {
      const record = await getRecord(foundDomain, recordId);
      if (record.subDomain === subdomain && record.fieldType === 'A') {
        core.info(`Found record for subdomain ${subdomain}`);
        foundRecordId = recordId;
        foundRecord = record;
        core.debug(JSON.stringify(foundRecord));
        break;
      }
    }

    if (!foundRecord) {
      // Create a new record if it doesn't exist
      const newRecord = {
        subDomain: subdomain,
        fieldType: 'A',
        target: ip
      };
      core.debug(JSON.stringify(newRecord));
      await createRecord(foundDomain, newRecord);
      core.info(`Created new record for subdomain ${subdomain} with IP ${ip}`);
    }
    else {
      foundRecord.target = ip;
      core.debug(JSON.stringify(foundRecord));
      await updateRecord(foundDomain, foundRecordId, foundRecord);
      core.info(`Updated record for subdomain ${subdomain} with IP ${ip}`);
    }

  } catch (error) {
    core.error(error.message);
  }
}

module.exports = {
  update
};