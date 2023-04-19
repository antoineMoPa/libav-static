import fs from 'fs';

const ffmpeg_libs = fs.readdirSync('./ffmpeg-libs').filter(file => /.*\.so\.[0-9]+\./.test(file))
const all_libs = fs.readdirSync('./ffmpeg-libs').filter(file => /.*\.so.*/.test(file))

all_libs.forEach(lib => {
    if (ffmpeg_libs.indexOf(lib) === -1) {
        fs.rmSync(`./ffmpeg-libs/${lib}`);
    }
});
