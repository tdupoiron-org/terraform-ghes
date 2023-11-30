var ovh = require('ovh');

function authenticate() {
  ovh = require('ovh')({
    appKey: process.env.OVH_APP_KEY,
    appSecret: process.env.OVH_APP_SECRET,
    consumerKey: process.env.OVH_CONSUMER_KEY
  });
  return ovh;
}

// GET all domains
function getDomains() {
  return new Promise((resolve, reject) => {
    ovh.request('GET', '/domain/zone', (err, domains) => {
      if (err) {
        reject(err);
      } else {
        resolve(domains);
      }
    });
  });
}

// Get all records for a domain
function getRecords(domain, type, subdomain) {
  return new Promise((resolve, reject) => {
    ovh.request('GET', `/domain/zone/${domain}/record?fieldType=${type}&subDomain=${subdomain}`, (err, records) => {
      if (err) {
        reject(err);
      } else {
        resolve(records);
      }
    });
  });
}

// Get a record in a domain
function getRecord(domain, id) {
  return new Promise((resolve, reject) => {
    ovh.request('GET', `/domain/zone/${domain}/record/${id}`, (err, record) => {
      if (err) {
        reject(err);
      } else {
        resolve(record);
      }
    });
  });
}

// Update a record in a domain
function updateRecord(domain, id, record) {
  return new Promise((resolve, reject) => {
    ovh.request('PUT', `/domain/zone/${domain}/record/${id}`, record, (err, record) => {
      if (err) {
        reject(err);
      } else {
        resolve(record);
      }
    });
  });
}

// Create a record in a domain
function createRecord(domain, record) {
  return new Promise((resolve, reject) => {
    ovh.request('POST', `/domain/zone/${domain}/record`, record, (err, record) => {
      if (err) {
        reject(err);
      } else {
        resolve(record);
      }
    });
  });
}

// Refresh a domain
function refreshDomain(domain) {
  return new Promise((resolve, reject) => {
    ovh.request('POST', `/domain/zone/${domain}/refresh`, (err, domain) => {
      if (err) {
        reject(err);
      } else {
        resolve(domain);
      }
    });
  });
}

// Export functions
module.exports = {
  authenticate,
  getDomains,
  getRecords,
  getRecord,
  updateRecord,
  createRecord,
  refreshDomain
};