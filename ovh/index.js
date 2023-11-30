
const core = require('@actions/core');
const ovhController = require('./ovh-controller');

process.env.OVH_APP_KEY = core.getInput('OVH_APP_KEY');
process.env.OVH_APP_SECRET = core.getInput('OVH_APP_SECRET');
process.env.OVH_CONSUMER_KEY = core.getInput('OVH_CONSUMER_KEY');

const action = core.getInput('action');

// Check if any of the required inputs are missing
const missingInputs = [];
if (!process.env.OVH_APP_KEY) {
  missingInputs.push('OVH_APP_KEY');
}
if (!process.env.OVH_APP_SECRET) {
  missingInputs.push('OVH_APP_SECRET');
}
if (!process.env.OVH_CONSUMER_KEY) {
  missingInputs.push('OVH_CONSUMER_KEY');
}
if (!action) {
  missingInputs.push('action');
}

if (missingInputs.length > 0) {
  core.setFailed(`Missing required inputs: ${missingInputs.join(', ')}`);
} else {
  handleAction(action);
}

function handleAction(action) {
  
  switch (action) {
    case 'updateGHESServerIP':
      core.info('Updating GHESServer IP');

      const domain = core.getInput('domain');
      const subdomain = core.getInput('subdomain');
      const ip = core.getInput('ip');

      ovhController.updateGHESServerIP(domain, subdomain, ip);
      break;

    default:
      core.setFailed(`Action ${action} not supported.`);
  }
}
