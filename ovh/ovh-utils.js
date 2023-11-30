var ovh = require('ovh')({
  appKey: process.env.OVH_APP_KEY,
  appSecret: process.env.OVH_APP_SECRET,
  consumerKey: process.env.OVH_CONSUMER_KEY
});

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
function getRecords(domain) {
  return new Promise((resolve, reject) => {
    ovh.request('GET', `/domain/zone/${domain}/record`, (err, records) => {
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

// Export functions
module.exports = {
  getDomains,
  getRecords,
  getRecord,
  updateRecord,
  createRecord
};