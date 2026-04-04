import instaloader
import os

L = instaloader.Instaloader(download_videos=False, save_metadata=False, post_metadata_txt_pattern='')

try:
    profile = instaloader.Profile.from_username(L.context, 'missroyaleelegance')
    
    with open('ig_content.txt', 'w', encoding='utf-8') as f:
        f.write(f'Profile Name: {profile.full_name}\n')
        f.write(f'Bio: {profile.biography}\n')
        f.write(f'External URL: {profile.external_url}\n')
        f.write('='*40 + '\n\n')
        
    print('Bio extracted.')
    
    posts = profile.get_posts()
    count = 0
    os.makedirs('images/ig_posts', exist_ok=True)
    
    for post in posts:
        if count >= 5:
            break
        print(f'Downloading post {count+1}...')
        L.download_post(post, target=f'images/ig_posts/post_{count}')
        
        with open('ig_content.txt', 'a', encoding='utf-8') as f:
            f.write(f'--- Post {count+1} ---\n')
            f.write(f'Date: {post.date}\n')
            f.write(f'Caption: {post.caption}\n\n')
            
        count += 1
    print('Done scraping.')
except Exception as e:
    print('Error:', e)