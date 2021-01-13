const nodemailer = require("nodemailer");
const fs = require("fs");
const args = process.argv.slice(2); //get user&password
const user = args[0];
const pass = args[1];
const errFileName = args[2];
const outFileName = args[3];
const emailTo = args[4];
let contents = "";
let subject = "";

if (args.length !== 5) {
  console.log("email setting is missing");
  console.log("can not send email");
  process.exit(1);
}

const main = async (subject, user, text, html, filename) => {
  let transporter = nodemailer.createTransport({
    service: "gmail",
    host: "smtp.gmail.com",
    port: 587,
    secure: false,
    auth: {
      user,
      pass,
    },
  });

  // send mail to User
  let info = await transporter.sendMail({
    from: `"Elastic_Rooling_Restart"`,
    to: user,
    subject,
    text,
    html,
    attachments: [
      {
        filename: filename,
        path: filename,
      },
    ],
  });

  // send mail to Email To
  let info2 = await transporter.sendMail({
    from: `"Elastic_Rooling_Restart"`,
    to: emailTo,
    subject,
    text,
    html,
    attachments: [
      {
        filename: filename,
        path: filename,
      },
    ],
  });

  console.log("Message sent: %s", info.messageId);
  console.log("Message sent: %s", info2.messageId);
};

try {
  if (fs.existsSync(errFileName)) {
    contents =
      "ERROR OCCURRED DURING ELASTIC_ROLLING_RESTART <br> Please Check Attached Log File";
    subject = "Elastic_Rolling_Restart ERROR OCCURRED";
    main(subject, user, contents, contents, errFileName);
  } else if (outFileName) {
    contents =
      "FISHED ELASTIC_ROLLING_RESTART <br>Please Check Attached Log File";
    subject = "Elastic_Rolling_Restart PROCESS DONE";
    main(subject, user, contents, contents, errFileName);
  } else {
    contents =
      "NO LOGS OUT DURING ELASTIC_ROLLING_RESTART <br> Please Check Server";
    subject = "Elastic_Rolling_Restart NO LOGS";
    main(subject, user, contents, contents, errFileName);
  }
} catch (err) {
  console.log(err);
}
