pub const common_magic1 = 0xc7b1dd30df4c8b88;
pub const common_magic2 = 0x0a82e883a194f07b;

const request = struct {
    id: [4]u64,
    revision: u64,
    response: u64
};

const LIMINE_BOOTLOADER_INFO_REQUEST_MAGIC = [4]u64{common_magic1, common_magic2, 0xf55038d8e2a1202f, 0x279426fcf5f59740};

pub fn limine_request(revision: u64) request {
    return request {
        .id = LIMINE_BOOTLOADER_INFO_REQUEST_MAGIC,
        .revision = revision,
        .response = 0
    };
}