const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const fs = require('fs');
const app = express();
const port = 8081;
app.use(bodyParser({ limit: '50mb' }));
app.use(express.json()); // for parsing application/json
app.all('/api/transfer', (req, res) => {
    // 保存数据
    const { type, data } = req.body;
    if ('image' === type) {
        saveImage(data, result => {
            out(res, result);
        });
    } else if('project' === type) {
        // 直接写入数据
        console.log('导入项目数据');
        saveData(data, result => {
            out(res, result);
        });
    } else {
        out(res, false);
    }
});

function out(res, result) {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'POST, GET, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', '*');
    res.setHeader('Content-Type', 'application/json; charset=UTF-8');
    res.send(result ? { code: 0, msg: 'ok!' } : { code: -1, msg: 'fail!' });
}

const dirPrefix = path.resolve(process.cwd(), 'transfer');

function saveImage(postData, callback) {
    const { map, data: base64Data } = postData;
    let fileName = '';
    if (/image\/jpe?g/) {
        //JPG格式
        fileName = `${map}.jpg`;
    } else {
        fileName = `${map}.png`;
    }
    binaryData = new Buffer(base64Data.replace(/^data:image\/(png|jpeg);base64,/, ''), 'base64').toString('binary');
    fs.writeFile(path.resolve(dirPrefix, fileName), binaryData, 'binary', function(err) {
        if (!err) {
            callback(true);
        } else {
            callback(false);
        }
    });
}

function saveData(postData, callback) {
    const { id } = postData;
    fileName = `${id}.json`;
    fs.writeFile(path.resolve(dirPrefix, fileName), JSON.stringify(postData), function(err) {
        if (!err) {
            callback(true);
        } else {
            callback(false);
        }
    });
}

app.listen(port, () => console.log(`transfer server listening on port ${port}!`));