use std::io::prelude::*;
use std::net::TcpListener;
use std::process::Command;

fn main() {
    let listener = TcpListener::bind("127.0.0.1:7878").unwrap();

    for stream in listener.incoming() {
        let mut stream = stream.unwrap();
        let mut buffer = [0; 512];
        stream.read(&mut buffer).unwrap();
        stream.write("HTTP/1.1 200 OK\r\n\r\n".as_bytes()).unwrap();
        stream.flush().unwrap();
        let _ = Command::new("osascript")
            .args(vec![
                "-e",
                "display notification \"Pinged!\" with title \"POC NOTIFIER\" sound name \"frog\"",
            ])
            .output();
    }
}
