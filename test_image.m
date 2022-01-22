image = imread('cameraman.tif');
image = imresize(image,[128 128]);
[rows, cols] = size(image);
%figure,imshow(image);
new_image = zeros(rows ,cols);
enc_image = zeros(rows,cols);

key_hex = cell(1,16);
key = input('Enter the value of the key for which you want to encrypt the image : ', 's');
key = fillspaces(key);
key = dec2hex(key,2);


for i=1:16
    key_hex{i} = key(i,:);
end
[s_box, inv_s_box, w, poly_mat, inv_poly_mat] = aes_init(key_hex);

 for i = 1:4:rows
     for j=1:4:cols
         
    blocks = image(i:i+3,j:j+3);
    block = reshape(blocks,1,16);
    enc_block = cipher (block, w, s_box, poly_mat, 1);
    enc_block = reshape(enc_block,4,4);
    enc_image(i:i+3,j:j+3) = enc_block;

     end
 end
 
 
 
key = input('Enter the value of the key for which you want to decrypt the image : ', 's');
key = fillspaces(key);
key = dec2hex(key,2);
key_hex = cell(1,16);

for i=1:16
    key_hex{i} = key(i,:);
end
[s_box, inv_s_box, w, poly_mat, inv_poly_mat] = aes_init(key_hex);

 for i = 1:4:rows
     for j=1:4:cols
         
    blocks = enc_image(i:i+3,j:j+3);
    block = reshape(blocks,1,16);
    re_block = inv_cipher (block, w, inv_s_box, inv_poly_mat, 1);
    re_block = reshape(re_block,4,4);
    new_image(i:i+3,j:j+3) = re_block;
     end
 end
 new_image = uint8(new_image);
 enc_image = uint8(enc_image);
 figure(1),
 subplot(1,3,1),imshow(image),title('Orginal image');
 subplot(1,3,2),imshow(enc_image),title('cipher image');
 subplot(1,3,3),imshow(new_image),title('Restored image');
